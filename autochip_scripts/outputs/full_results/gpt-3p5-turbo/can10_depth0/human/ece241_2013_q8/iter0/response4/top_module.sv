module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

// Define the states of the FSM
parameter S0 = 0;
parameter S1 = 1;
parameter S2 = 2;

// Define the current state signal of the FSM
reg [1:0] state;

// Define the next state signal of the FSM
wire [1:0] next_state;

// Define the output logic of the FSM
assign z = (state == S1 && x);

// Sequential logic for state transition
always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= S0;
    end else begin
        state <= next_state;
    end
end

// Next state logic
always @(*) begin
    case (state)
        S0: begin
            if (x)
                next_state = S1;
            else
                next_state = S0;
        end
        
        S1: begin
            if (x)
                next_state = S2;
            else
                next_state = S0;
        end
        
        S2: begin
            if (x)
                next_state = S1;
            else
                next_state = S0;
        end
    endcase
end

endmodule
