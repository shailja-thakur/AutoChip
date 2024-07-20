module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

// Define the states of the Mealy FSM
localparam [1:0] 
    S0 = 2'b00, // Initial state
    S1 = 2'b01, // Seen '1'
    S2 = 2'b10; // Seen '01'

// State register
reg [1:0] state;

always @(posedge clk, negedge aresetn) begin
    if (!aresetn) begin
        // Asynchronous reset
        state <= S0;
        z <= 1'b0;
    end else begin
        case (state)
            S0: begin
                // Initial state
                if (x == 1'b1) begin
                    state <= S1;
                    z <= 1'b0;
                end else begin
                    state <= S0;
                    z <= 1'b0;
                end
            end
            S1: begin
                // Seen '1'
                if (x == 1'b0) begin
                    state <= S2;
                    z <= 1'b0;
                end else begin
                    state <= S1;
                    z <= 1'b0;
                end
            end
            S2: begin
                // Seen '01'
                if (x == 1'b1) begin
                    state <= S1;
                    z <= 1'b1; // Detect the '101' sequence
                end else begin
                    state <= S0;
                    z <= 1'b0;
                end
            end
            default: begin
                state <= S0;
                z <= 1'b0;
            end
        endcase
    end
end

endmodule
