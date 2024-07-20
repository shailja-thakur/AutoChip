module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    reg [2:0] state;
    reg previous_bit;

    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
            previous_bit <= 0;
            done <= 0;
        end else begin
            case (state)
                0: begin
                    if (in[3] == 1) begin
                        state <= 1;
                    end
                end
                1: begin
                    if (in[3] == 1 && previous_bit == 0) begin
                        state <= 2;
                    end else begin
                        state <= 0;
                    end
                    previous_bit <= in[3]; // Store the current bit for next cycle
                end
                2: begin
                    if (in[3] == 1 && previous_bit == 1) begin
                        state <= 3;
                    end else begin
                        state <= 0;
                    end
                    previous_bit <= in[3]; // Store the current bit for next cycle
                end
                3: begin
                    state <= 0;
                    done <= 1;
                end
                default: begin
                    state <= 0;
                    done <= 0;
                end
            endcase
        end
    end

endmodule
