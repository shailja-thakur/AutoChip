module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);
    reg [2:0] state;
    reg [2:0] next_state;

    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000;
            out_bytes <= 24'b0;
            done <= 0;
        end else begin
            state <= next_state;
            case (state)
                3'b000: begin
                    if (in[2] == 1)
                        next_state = 3'b001;
                    else
                        next_state = 3'b000;
                end
                3'b001: begin
                    if (in[2] == 0)
                        next_state = 3'b000;
                    else
                        next_state = 3'b010;
                end
                3'b010: begin
                    if (in[2] == 0)
                        next_state = 3'b000;
                    else
                        next_state = 3'b011;
                end
                3'b011: begin
                    if (in[2] == 0)
                        next_state = 3'b000;
                    else
                        next_state = 3'b000;
                end
                default: next_state = 3'b000;
            endcase
            
            if (state == 3'b011) begin
                done <= 1;
                out_bytes <= {out_bytes[15:0], in};
            end if (state == 3'b000) begin
                done <= 0;
                out_bytes <= {out_bytes[15:0], 8'b0};
            end
        end
    end
endmodule
