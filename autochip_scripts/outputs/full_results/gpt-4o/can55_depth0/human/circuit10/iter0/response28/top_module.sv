module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output state
);

    reg internal_state;

    assign state = internal_state;

    always @(posedge clk) begin
        if (a & b) begin
            internal_state <= ~internal_state;
        end else if (a) begin
            internal_state <= 1'b0;
        end else if (b) begin
            internal_state <= 1'b1;
        end
    end
    
    always @(posedge clk) begin
        case({a, b})
            2'b00: q <= internal_state;
            2'b01: q <= 1'b1;
            2'b10: q <= 1'b0;
            2'b11: q <= ~internal_state;
        endcase
    end

endmodule
