module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);

    // State machine variables
    reg [1:0] state = 0;
    reg start_shifting = 0;

    // FSM logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
        end else begin
            case (state)
                0: begin
                    if (data == 1) begin
                        state <= 1;
                    end else begin
                        state <= 0;
                    end
                end
                1: begin
                    if (data == 1) begin
                        state <= 2;
                    end else begin
                        state <= 0;
                    end
                end
                2: begin
                    if (data == 1) begin
                        state <= 3;
                    end else begin
                        state <= 0;
                    end
                end
                3: begin
                    if (data == 0) begin
                        state <= 0;
                        start_shifting <= 1;
                    end else begin
                        state <= 0;
                    end
                end
            endcase
        end
    end

endmodule