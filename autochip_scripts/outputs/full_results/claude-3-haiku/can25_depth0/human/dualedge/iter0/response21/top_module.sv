module top_module(
    input clk,
    input d,
    output reg q
);

    reg q_pos, q_neg;

    always @(posedge clk) begin
        q_pos <= d;
    end

    always @(negedge clk) begin
        q_neg <= d;
    end

    always @(*) begin
        case ({q_pos, q_neg})
            2'b00: q <= q_pos;
            2'b01: q <= q_neg;
            2'b10: q <= q_pos;
            2'b11: q <= q_pos; // Undefined behavior, but choose q_pos for consistency
        endcase
    end

endmodule
