module flipflop(
    input clk,
    input reset,
    input D,
    output reg Q
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            Q <= 0;
        else
            Q <= D;
    end
endmodule
module multiplexer(
    input sel,
    input [1:0] data,
    output reg out
);
    always @(sel or data) begin
        case(sel)
            2'b00: out = data[0];
            2'b01: out = data[1];
            2'b10: out = data[0];
            default: out = data[1];
        endcase
    end
endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);
    wire [2:0] r;
    wire [2:0] q;
    
    flipflop ff1(
        .clk(clk),
        .reset(0),
        .D(q_in),
        .Q(q[0])
    );
    
    flipflop ff2(
        .clk(clk),
        .reset(0),
        .D(q[1]),
        .Q(q[2])
    );
    
    flipflop ff3(
        .clk(clk),
        .reset(0),
        .D(r_in),
        .Q(r[0])
    );
    
    multiplexer mux(
        .sel(L),
        .data({q[1], q[2]}),
        .out(r[1])
    );
    
    flipflop ff4(
        .clk(clk),
        .reset(0),
        .D(r[1]),
        .Q(r[2])
    );
    
    assign Q = q[0];
    
endmodule
