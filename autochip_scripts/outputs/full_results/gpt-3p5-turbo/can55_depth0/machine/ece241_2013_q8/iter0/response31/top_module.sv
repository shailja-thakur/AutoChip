module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

// Define the states
parameter S = 2'b00;
parameter S1 = 2'b01;
parameter S10 = 2'b10;

// Declare state variables
reg [1:0] state;
reg [1:0] state_next;

// Define the state transition logic
always @(posedge clk, negedge aresetn) begin
    if (!aresetn) begin
        state <= S; // Initial state
    end else begin
        state <= state_next;
    end
end

// Define the next state logic based on input x and current state
always @(state, x) begin
    case (state)
        S: begin
            if (x == 1'b1) begin
                state_next = S1;
            end else begin
                state_next = S;
            end
        end
        S1: begin
            if (x == 1'b1) begin
                state_next = S1;
            end else begin
                state_next = S10;
            end
        end
        S10: begin
            if (x == 1'b1) begin
                state_next = S1;
            end else begin
                state_next = S;
            end
        end
        default: state_next = S; // Default state
    endcase
end

// Define the output z based on current state
always @(state) begin
    case (state)
        S, S1: z = 1'b0;
        S10: z = x;
        default: z = 1'b0; // Default output
    endcase
end

endmodule
