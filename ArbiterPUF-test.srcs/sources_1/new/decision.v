module decision(
    input wire [1:0] in,
    output wire response
);
    wire Q, Qn;
    
    assign Q = ~(in[0] & in[1]);
    assign Qn = ~(in[1] & Q);
    
    assign response = Qn;

endmodule
