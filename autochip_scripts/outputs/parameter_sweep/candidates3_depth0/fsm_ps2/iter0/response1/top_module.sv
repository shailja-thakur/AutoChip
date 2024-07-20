module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    reg [2:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000; // Initial state
            done <= 0;
        end else begin
            case (state)
                3'b000: begin // Wait for in[3] = 1
                    if (in[3] == 1) begin
                        state <= 3'b001; // Transition to byte 1 state
                    end
                end
                3'b001: begin // Receive byte 1
                    state <= 3'b010; // Transition to byte 2 state
                end
                3'b010: begin // Receive byte 2
                    state <= 3'b011; // Transition to byte 3 state
                end
                3'b011: begin // Receive byte 3
                    state <= 3'b000; // Transition to wait state
                    done <= 1; // Signal message received
                end
                default: state <= 3'b000; // Default state
            endcase
        end
    end

endmodule
