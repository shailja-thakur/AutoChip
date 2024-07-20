module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;

// Initializing the state to S
initial begin
    state = 2'b00;
end

// Assigning next_state based on current state and input x
always @(posedge clk or negedge aresetn) begin
    if (~aresetn) begin
        state <= 2'b00; // Reset the state to S
    end else begin
        case(state)
            2'b00: begin // S state
                if (x == 1'b0) begin
                    next_state = 2'b00; // S
                end else begin
                    next_state = 2'b01; // S1
                end
            end
            
            2'b01: begin // S1 state
                if (x == 1'b0) begin
                    next_state = 2'b10; // S10
                end else begin
                    next_state = 2'b01; // S1
                end
            end
            
            2'b10: begin // S10 state
                if (x == 1'b0) begin
                    next_state = 2'b00; // S
                end else begin
                    next_state = 2'b01; // S1
                end
            end
            
            default: next_state = 2'b00; // Default to S state
        endcase
    end
end

// Assigning output z based on current state
always @(state) begin
    case(state)
        2'b00: z = 1'b0; // S state
        2'b01: z = 1'b0; // S1 state
        2'b10: z = x;   // S10 state
        default: z = 1'b0; // Default to 0
    endcase
end

endmodule
