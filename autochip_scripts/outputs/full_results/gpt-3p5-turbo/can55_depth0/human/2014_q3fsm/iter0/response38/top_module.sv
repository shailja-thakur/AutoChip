module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    reg [1:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00;  // reset state A
        end else begin
            case (state)
                2'b00: begin
                    if (s == 1) begin
                        state <= 2'b01;  // transition to state B
                    end
                end
                2'b01: begin
                    // count the number of consecutive w = 1 occurrences
                    if (w == 1) begin
                        state <= 2'b10;
                    end else begin
                        state <= 2'b00;  // back to state A
                    end
                end
                2'b10: begin
                    if (w == 1) begin
                        state <= 2'b10;  // stay in state B
                    end else begin
                        state <= 2'b11;  // transition to the final state
                    end
                end
                2'b11: begin
                    if (w == 1) begin
                        state <= 2'b01;  // back to state B
                    else
                        state <= 2'b00;  // back to state A
                    end
                end
            endcase
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            z <= 0;
        end else begin
            if (state == 2'b11) begin
                z <= 1;
            end else begin
                z <= 0;
            end
        end
    end

endmodule
