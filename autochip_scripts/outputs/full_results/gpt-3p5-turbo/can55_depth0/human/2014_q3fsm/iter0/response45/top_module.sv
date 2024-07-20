module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

// Define the states
parameter A = 1'b0;
parameter B = 1'b1;

reg state;
reg nextState;

// Define the current state
always @(posedge clk, posedge reset) begin
    if (reset) begin
        state <= A;
    end else begin
        state <= nextState;
    end
end

// Define the next state and the output logic
always @(state, w) begin
    case (state)
        A: begin
            nextState = (s) ? B : A;
        end
        
        B: begin
            if (w) begin
                nextState = nextState + 1;
            end else begin
                nextState = B;
            end
        end
        
        default: begin
            nextState = A;
        end
    end
    
    if (nextState == B && nextState[1] == 1 && nextState[0] == 1) begin
        z = 1;
    end else begin
        z = 0;
    end
end

endmodule
