module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); //

    // Insert your code below

    // State transition logic (combinational)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            case (state)
                IDLE: begin
                    if (in[3] == 1) begin
                        state <= RECEIVING_FIRST_BYTE;
                    end
                end
                RECEIVING_FIRST_BYTE: begin
                    if (in[3] == 0) begin
                        state <= IDLE;
                    end else begin
                        state <= RECEIVING_SECOND_BYTE;
                    end
                end
                RECEIVING_SECOND_BYTE: begin
                    if (in[3] == 0) begin
                        state <= IDLE;
                    end else begin
                        state <= RECEIVING_THIRD_BYTE;
                    end
                end
                RECEIVING_THIRD_BYTE: begin
                    if (in[3] == 0) begin
                        state <= IDLE;
                    end else begin
                        state <= DONE;
                    end
                end
            endcase
        end
    end

    // State flip-flops (sequential)
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end
    end

    // Output logic
    output reg done;
    always @(posedge clk) begin
        done <= state == DONE;
    end

endmodule