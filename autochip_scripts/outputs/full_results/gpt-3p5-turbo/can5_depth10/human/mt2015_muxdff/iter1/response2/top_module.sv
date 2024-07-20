module flipflop(
    input clk,
    input D,
    output reg Q
);
    always @(posedge clk) begin
        Q <= D;
    end
endmodule
module mux_2to1(
    input I0,
    input I1,
    input S,
    output reg Y
);
    always @(*) begin
        case (S)
            2'b00: Y <= I0;
            2'b01: Y <= I1;
            2'b10: Y <= 1'b0;
            2'b11: Y <= 1'b1;
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
    reg q0, q1, q2;
    wire m0_out, m1_out, m2_out;
    
    always @(posedge clk) begin
        if (L) begin
            q0 <= r_in;
            q1 <= r_in;
            q2 <= r_in;
        end else begin
            q0 <= m2_out;
            q1 <= q0;
            q2 <= q1;
        end
    end
    
    mux_2to1 mux0 (.I0(r_in), .I1(q2), .S(L), .Y(m0_out));
    mux_2to1 mux1 (.I0(m0_out), .I1(q0), .S(L), .Y(m1_out));
    mux_2to1 mux2 (.I0(m1_out), .I1(q1), .S(L), .Y(m2_out));
    
    always @(posedge clk) begin
        if (L) begin
            Q <= r_in;
        end else begin
            Q <= m2_out;
        end
    end
endmodule
