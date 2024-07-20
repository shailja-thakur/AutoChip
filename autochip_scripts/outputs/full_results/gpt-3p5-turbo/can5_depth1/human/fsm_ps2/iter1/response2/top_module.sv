module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    reg [2:0] state;
    reg [7:0] byte_count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            byte_count <= 0;
            done <= 0;
        end else begin
            case (state)
                0: begin
                    if (in[3] == 1) begin
                        state <= 1;
                        byte_count <= 1;
                        done <= 0;
                    end
                end
                1: begin
                    if (in[3] == 0) begin
                        state <= 0;
                        byte_count <= 0;
                    end else begin
                        state <= 2;
                    end
                end
                2: begin
                    if (in[3] == 0) begin
                        state <= 0;
                        byte_count <= 0;
                    end else begin
                        state <= 3;
                    end
                end
                3: begin
                    state <= 0;
                    byte_count <= 0;
                    done <= 1;
                end
                default: begin
                    state <= 0;
                    byte_count <= 0;
                    done <= 0;
                end
            endcase
        end
    end

endmodule
