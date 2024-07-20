module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [1:0] state;
    reg [1:0] next_state;
    reg [23:0] shifted_in;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00;
            out_bytes <= 0;
            shifted_in <= 0;
            done <= 0;
        end else begin
            state <= next_state;
            case (state)
                2'b00: begin
                    if (in[2] == 1) begin
                        next_state <= 2'b01;
                        done <= 0;
                    end else begin
                        next_state <= 2'b00;
                        done <= 0;
                    end
                    shifted_in <= in;
                end
                2'b01: begin
                    if (in[2] == 1) begin
                        next_state <= 2'b10;
                        done <= 0;
                    end else begin
                        next_state <= 2'b00;
                        done <= 0;
                    end
                    shifted_in <= shifted_in << 8;
                    shifted_in[7:0] <= in;
                end
                2'b10: begin
                    if (in[2] == 1) begin
                        next_state <= 2'b11;
                        done <= 0;
                    end else begin
                        next_state <= 2'b00;
                        done <= 0;
                    end
                    shifted_in <= shifted_in << 8;
                    shifted_in[15:8] <= in;
                end
                2'b11: begin
                    next_state <= 2'b00;
                    done <= 1;
                    out_bytes <= shifted_in;
                end
                default: next_state <= 2'b00;
            endcase
        end
    end

endmodule
