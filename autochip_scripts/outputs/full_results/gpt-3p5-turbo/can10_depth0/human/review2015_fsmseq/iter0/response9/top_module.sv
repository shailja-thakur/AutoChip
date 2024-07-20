module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);
    
    reg [3:0] state;
    reg [3:0] next_state;
    
    parameter S0 = 4'b0000;  // Initial state
    parameter S1 = 4'b0001;  // State after reading 1
    parameter S2 = 4'b0010;  // State after reading 11
    parameter S3 = 4'b0011;  // State after reading 110
    parameter S4 = 4'b0100;  // State after reading 1101
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S0;  // Reset to initial state
            start_shifting <= 0;  // Reset start_shifting
        end else begin
            state <= next_state;
            start_shifting <= (state == S4);  // Set start_shifting to 1 when sequence is found
        end
    end
    
    always @(*) begin
        case (state)
            S0: begin
                if (data) begin
                    next_state = S1;
                end else begin
                    next_state = S0;
                end
            end
            S1: begin
                if (data) begin
                    next_state = S2;
                end else begin
                    next_state = S0;
                end
            end
            S2: begin
                if (data) begin
                    next_state = S3;
                end else begin
                    next_state = S0;
                end
            end
            S3: begin
                if (data) begin
                    next_state = S4;
                end else begin
                    next_state = S0;
                end
            end
            S4: begin
                next_state = S0;
            end
        endcase
    end
endmodule
