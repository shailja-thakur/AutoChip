module top_module (
    input clk,
    input reset,
    input w,
    output z
);

    // Declare the states
    parameter A = 0;
    parameter B = 1;
    parameter C = 2;
    parameter D = 3;
    parameter E = 4;
    parameter F = 5;

    // Declare the current state and next state variables
    reg [2:0] current_state;
    reg [2:0] next_state;

    // Assign the initial state
    initial begin
        current_state <= A;
    end
    
    // Always block to handle state transitions and outputs
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end
    
    // Assign the next state based on the current state and input w
    always @* begin
        case (current_state)
            A: begin
                if (w == 0) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
            B: begin
                if (w == 1) begin
                    next_state = D;
                end else begin
                    next_state = C;
                end
            end
            C: begin
                if (w == 1) begin
                    next_state = D;
                end else begin
                    next_state = E;
                end
            end
            D: begin
                if (w == 1) begin
                    next_state = A;
                end else begin
                    next_state = F;
                end
            end
            E: begin
                if (w == 1) begin
                    next_state = D;
                end else begin
                    next_state = E;
                end
            end
            F: begin
                if (w == 1) begin
                    next_state = D;
                end else begin
                    next_state = C;
                end
            end
        endcase
    end
    
    // Output z is high when in state E or F, and low otherwise
    assign z = (current_state == E || current_state == F) ? 1'b1 : 1'b0;
    
endmodule
