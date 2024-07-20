module top_module(
    input clk,
    input reset,
    input data,
    output start_shifting);

    // Define states as parameters
    parameter [2:0] S = 3'b000;
    parameter [2:0] S1 = 3'b001;
    parameter [2:0] S11 = 3'b010;
    parameter [2:0] S110 = 3'b011;
    parameter [2:0] Done = 3'b100;

    // Define registers
    reg [2:0] state;
    reg start_shifting;

    // Combinational logic block to determine the next state and output
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            state <= S; // Reset to initial state
        end else begin
            case (state)
                S: begin
                    if (data) begin
                        state <= S1;
                    end else begin
                        state <= S;
                    end
                end
                S1: begin
                    if (data) begin
                        state <= S11;
                    end else begin
                        state <= S;
                    end
                end
                S11: begin
                    if (data) begin
                        state <= S11;
                    end else begin
                        state <= S110;
                    end
                end
                S110: begin
                    if (data) begin
                        state <= Done;
                    end else begin
                        state <= S;
                    end
                end
                Done: begin
                    state <= Done;
                end
            endcase
        end
    end

    // Assign output based on the current state
    assign start_shifting = (state == Done) ? 1'b1 : 1'b0;

endmodule
