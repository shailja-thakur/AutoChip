module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    reg [1:0] state;
    reg out_reg;

    always @(posedge clk) begin
        if (reset) begin
            state <= 2'b00;  // set initial state to A
        end else begin
            case (state)
                2'b00: begin  // state A
                    if (in) begin
                        state <= 2'b01;  // transition to state B
                    end
                end
                2'b01: begin  // state B
                    if (in) begin
                        state <= 2'b01;  // remain in state B
                    end else begin
                        state <= 2'b10;  // transition to state C
                    end
                end
                2'b10: begin  // state C
                    if (in) begin
                        state <= 2'b11;  // transition to state D
                    end else begin
                        state <= 2'b00;  // transition to state A
                    end
                end
                2'b11: begin  // state D
                    if (in) begin
                        state <= 2'b01;  // transition to state B
                    end else begin
                        state <= 2'b10;  // transition to state C
                    end
                end
            endcase
        end
    end

    always @(state) begin
        if (state == 2'b11) begin  // if state is D
            out_reg <= 1'b1;
        end else begin
            out_reg <= 1'b0;
        end
    end

    assign out = out_reg;

endmodule
