module top_module(
    input clk,
    input reset,
    input data,
    output start_shifting);

    // Define states
    parameter S = 2'b00;
    parameter S1 = 2'b01;
    parameter S11 = 2'b10;
    parameter S110 = 2'b11;
    parameter Done = 2'b11;

    // Declare internal signals
    reg [1:0] state;
    reg start_shifting;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S;
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

    // Output assignment
    always @(state) begin
        if (state == Done) begin
            start_shifting = 1'b1;
        end else begin
            start_shifting = 1'b0;
        end
    end

endmodule
