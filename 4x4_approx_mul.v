`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: IITR - PaAC
// Engineer: Revanth
// 
// Create Date: 11.01.2025 14:50:37
// Design Name: 4x4 bit approximate multiplier
// Module Name: _4x4_approx_mul
// Project Name: Approximate Multipliers
// 
//////////////////////////////////////////////////////////////////////////////////

module ha(a,b,s,c);

    input a,b;
    output s,c;
    
    // exact ha
    /*
    xor _s(s,a,b);
    and _c(c,a,b);
    */
    
    // approx 1
    or _s(s,a,b);
    and _c(c,a,b);

endmodule

module fa(a,b,cin,s,cout);

    input a,b,cin;
    output s,cout;
    
    // exact
    /*
    wire s1,co1,co2;
    
    xor _s1(s1,a,b);
    xor _s(s,s1,cin);
    and _co1(co1,s1,cin);
    and _co2(co2,a,b);
    or _co(cout,co1,co2);
    */
    
    // approx 1
    /*
    assign s = (a|b)^cin;
    assign cout = (a&b) | (b&cin);
    */
    
    // approx 2
    /*
    assign cout = (a&b) | (b&cin);
    assign s = ~cout;
    */
    
    // approx 3
    /*
    assign cout = a;
    assign s = (a|b)^cin;
    */
    
    // approx 4
    assign cout = a;
    assign s = b;

endmodule

module compressor(a,b,c,d,cin,s,cout,carry);
    // adds 4 bits + cin and generates 2(sum & cout) + 1(carry) outputs
    // cout goes to the next column in the same stage of partial product reduction
    // carry goes to the next column in the next stage

    input a,b,c,d,cin;
    output s,cout,carry;
    
    // exact compressor
    /*
    wire s1;
    
    fa _1(a,b,c,s1,cout);
    fa _2(s1,d,cin,s,carry);
    */
    
    // approx 1
    assign carry = cin;
    assign s = (a^b) | (c^d);
    assign cout = (a&b) | (c&d);

endmodule

module _4x4_approx_mul(A,B,result);

    input [3:0] A,B;
    output [7:0] result;
    
    // using a,b instead of A,B
    wire [3:0] a,b;
    
    assign a = A;
    assign b = B;
    
    // partial products    
    and _a00(a00,a[0],b[0]);
    and _a11(a11,a[1],b[1]);
    and _a22(a22,a[2],b[2]);
    and _a33(a33,a[3],b[3]);      
    and _a01(a01,a[0],b[1]);
    and _a02(a02,a[0],b[2]);
    and _a12(a12,a[1],b[2]);
    and _a03(a03,a[0],b[3]);
    and _a13(a13,a[1],b[3]);
    and _a23(a23,a[2],b[3]);
    and _a10(a10,a[1],b[0]);
    and _a20(a20,a[2],b[0]);
    and _a21(a21,a[2],b[1]);
    and _a30(a30,a[3],b[0]);
    and _a31(a31,a[3],b[1]);
    and _a32(a32,a[3],b[2]);
    
    // propagate terms    
    or _p10(p10,a10,a01);
    or _p20(p20,a20,a02);
    or _p21(p21,a21,a12);
    or _p30(p30,a30,a03);
    or _p31(p31,a31,a13);
    or _p32(p32,a32,a23);
    
    // generate terms
    and _g10(g10,a10,a01);
    and _g20(g20,a20,a02);
    and _g21(g21,a21,a12);
    and _g30(g30,a30,a03);
    and _g31(g31,a31,a13);
    and _g32(g32,a32,a23);    
    
    // partial products reduction stage 1
    ha _s1(p10,g10,s1,c1);
    compressor _s2(c1,p20,g20,a11,0,s2,c2,c2_);
    compressor _s3(c2,p30,g30,p21,g21,s3,c3,c3_);
    compressor _s4(c3,p31,g31,a22,0,s4,c4,c4_);
    fa _s5(c4,p32,g32,s5,c5);
    ha _s6(c5,a33,s6,c6_);
    
    // final output bits    
    ha _o3(s3,c2_,o3,c31);
    fa _o4(c31,s4,c3_,o4,c41);
    fa _o5(c41,s5,c4_,o5,c51);
    ha _o6(c51,s6,o6,c61);
    ha _o7(c61,c6_,o7,o8);
    
    assign result = {o7,o6,o5,o4,o3,s2,s1,a00};

endmodule
