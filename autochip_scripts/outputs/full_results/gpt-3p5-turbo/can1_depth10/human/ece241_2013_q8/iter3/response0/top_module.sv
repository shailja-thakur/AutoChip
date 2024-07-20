module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state;
reg [1:0] next_state;
reg [1:0] prev_state;

// State definitions
parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;

always @(posedge clk or negedge aresetn) begin
    if (~aresetn) begin
        state <= S0; // Initial state
    end 
    else begin
        state <= next_state; // Update state based on next_state
    end
end

always @(*) begin
    next_state = state;
    z = 0; // Default output is 0
    
    case (state)
        S0: begin
            if (x == 1'b1) begin
                next_state = S1;
            end
        end

        S1: begin
            if (x == 1'b0) begin
                next_state = S2;
            end
        end

        S2: begin
            if (x == 1'b1) begin
                next_state = S0;
                z = 1'b1; // Detected "101" sequence, output is 1
            end 
            else if (x == 1'b0) begin
                next_state = S1;
            end
        end

        default: next_state = S0;
    endcase
end

endmodule
