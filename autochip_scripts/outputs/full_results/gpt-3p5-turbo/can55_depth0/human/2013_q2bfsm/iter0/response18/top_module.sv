module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output f,
    output g
);

// Define states
typedef enum logic [1:0] {A, B, C, D} state;

// Declare variables
reg nextState;
reg currentState;
reg nextF;
reg nextG;

// Assign initial state
initial begin
    currentState = A;
end

// Define FSM
always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        currentState <= A;
    end else begin
        currentState <= nextState;
    end
end

always @(currentState) begin
    case (currentState)
        A: begin
            nextF = 0;
            nextG = 0;
            if (!resetn) begin
                nextState = A;
            end else if (x == 1'b1 && $past(x) == 1'b0 && $past($past(x)) == 1'b1) begin
                nextState = B;
                nextF = 1;
            end else begin
                nextState = A;
            end
        end
        
        B: begin
            nextF = 0;
            nextG = 0;
            if (!resetn) begin
                nextState = A;
            end else if (x == 1'b1 && $past(x) == 1'b0 && $past($past(x)) == 1'b1) begin
                nextState = C;
                nextF = 1;
            end else begin
                nextState = A;
            end
        end
        
        C: begin
            nextF = 0;
            nextG = 0;
            if (!resetn) begin
                nextState = A;
            end else if (x == 1'b1 && $past(x) == 1'b0 && $past($past(x)) == 1'b1) begin
                nextState = D;
                nextF = 1;
            end else begin
                nextState = A;
            end
        end
        
        D: begin
            nextF = 0;
            nextG = 0;
            if (!resetn) begin
                nextState = A;
            end else if (y == 1'b1) begin
                nextState = D;
                nextG = 1;
            end else begin
                nextState = A;
            end
        end
    endcase
end

// Assign outputs
always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        f <= 0;
        g <= 0;
    end else begin
        f <= nextF;
        g <= nextG;
    end
end

endmodule
