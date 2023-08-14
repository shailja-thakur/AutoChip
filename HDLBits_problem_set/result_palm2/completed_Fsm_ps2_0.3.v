module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); //

    // State transition logic (combinational)

    // State flip-flops (sequential)
 
    // Output logic

    reg [3:0] state;
    reg done;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
        end else begin
            case (state)
                0: begin
                    if (in[3] == 1) begin
                        state <= 1;
                    end else begin
                        state <= 0;
                    end
                end
                1: begin
                    if (in[3] == 1) begin
                        state <= 2;
                    end else begin
                        state <= 0;
                    end
                end
                2: begin
                    if (in[3] == 1) begin
                        state <= 3;
                    end else begin
                        state <= 0;
                    end
                end
                3: begin
                    done <= 1;
                    state <= 0;
                end
            endcase
        end
    end

    assign done = state == 3;

endmodule