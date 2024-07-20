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

// Define the current state and next state variables
reg [1:0] state;
reg [1:0] state_next;

// Assign the next state based on the inputs
always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= S;
    end else begin
        state <= state_next;
    end
end

// Update the next state based on the current state and input x
always @(state or x) begin
    case (state)
        S: begin
            if (x) begin
                state_next = S1;
            end else begin
                state_next = S;
            end
        end
        S1: begin
            if (x) begin
                state_next = S1;
            end else begin
                state_next = S10;
            end
        end
        S10: begin
            if (x) begin
                state_next = S1;
            end else begin
                state_next = S;
            end
        end
        default: begin
            state_next = S;
        end
    endcase
end

// Assign the output z based on the current state
always @(state) begin
    case (state)
        S: begin
            z = 1'b0;
        end
        S1: begin
            z = 1'b0;
        end
        S10: begin
            z = x;
        end
        default: begin
            z = 1'b0;
        end
    endcase
end

endmodule
