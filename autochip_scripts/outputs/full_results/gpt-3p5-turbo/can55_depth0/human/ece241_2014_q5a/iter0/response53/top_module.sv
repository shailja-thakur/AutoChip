module top_module (
    input clk,
    input areset,
    input x,
    output z
);
    
    reg signed [31:0] Z;
    reg [1:0] state, next_state;
    
    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    
    // State transition
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S0; // Reset to initial state
        end else begin
            state <= next_state;
        end
    end
    
    // Next state and output logic
    always @(state or x) begin
        case (state)
            S0: begin
                if (x) begin
                    next_state = S1;
                end else begin
                    next_state = S0;
                end
                Z <= 0; // Output is 0
            end
            
            S1: begin
                if (x) begin
                    next_state = S2;
                end else begin
                    next_state = S1;
                end
                Z <= Z + 1; // Add 1 to the output
            end
            
            S2: begin
                if (x) begin
                    next_state = S2;
                end else begin
                    next_state = S1;
                end
                Z <= Z; // Output remains the same
            end
        endcase
    end
    
    // Output assignment
    assign z = Z;
    
endmodule
