module top_module (
    input clk,
    input areset,
    input x,
    output z
);

parameter A = 2'b00;   // Define the state A
parameter B = 2'b01;   // Define the state B
parameter C = 2'b10;   // Define the state C

reg [1:0] state;    // Register to store the state of the machine

always @(posedge clk or areset) begin
    if (areset) begin
        state <= A;          // Set the state to A if reset signal is triggered
    end
    else begin
        case (state)   // Determine the state based on the current state
            A: begin
                if (x) begin
                    state <= C;   // Set state to C if x is true
                end
                else begin
                    state <= A;   // Stay in state A if x is false
                end
            end
            B: begin
                if (x) begin
                    state <= B;   // Stay in state B if x is true
                end
                else begin
                    state <= C;   // Set state to C if x is false
                end
            end
            C: begin
                if (x) begin
                    state <= B;   // Set state to B if x is true
                end
                else begin
                    state <= C;   // Stay in state C if x is false
                end
            end
        endcase
    end
end

assign z = (state == C) ? 1'b1 : 1'b0;   // Set output z based on state

endmodule
