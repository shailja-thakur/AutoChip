module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    reg [1:0] state;
    wire [1:0] next_state;
    
    // Define the states
    parameter A = 2'b00;
    parameter B = 2'b01;
    
    // Define the outputs
    assign z = state[1];
    
    // Define the state transition and output logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end
    
    // Define the next state logic
    always @* begin
        case (state)
            A: begin
                if (x) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
            B: begin
                if (x) begin
                    next_state = B;
                end else begin
                    next_state = B;
                end
            end
            default: next_state = A;
        endcase
    end
    
endmodule
