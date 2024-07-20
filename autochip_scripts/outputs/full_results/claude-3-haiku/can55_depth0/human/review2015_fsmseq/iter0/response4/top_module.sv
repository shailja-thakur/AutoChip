module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

// Define the states of the FSM
localparam [1:0] 
    S0 = 2'b00, // Waiting for '1'
    S1 = 2'b01, // Waiting for '1'
    S2 = 2'b10, // Waiting for '0'
    S3 = 2'b11; // Waiting for '1', sequence found

// Register to hold the current state
reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        // Reset the FSM to the initial state
        state <= S0;
        start_shifting <= 1'b0;
    end
    else begin
        case (state)
            S0: begin
                // Waiting for '1'
                if (data) begin
                    state <= S1;
                end
                else begin
                    state <= S0;
                end
            end
            S1: begin
                // Waiting for '1'
                if (data) begin
                    state <= S2;
                end
                else begin
                    state <= S0;
                end
            end
            S2: begin
                // Waiting for '0'
                if (~data) begin
                    state <= S3;
                end
                else begin
                    state <= S0;
                end
            end
            S3: begin
                // Waiting for '1', sequence found
                start_shifting <= 1'b1;
                state <= S3;
            end
            default: begin
                state <= S0;
            end
        endcase
    end
end

endmodule
