module top_module (
    input clk,
    input areset,
    input x,
    output z
);
    
    // Mealy machine states
    reg [1:0] state, next_state;
    
    // Output
    reg z_output;
    
    // State assignments
    parameter A = 2'b00;
    parameter B = 2'b01;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end
    
    // Next state logic
    always @(state or x) begin
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
        endcase
    end
    
    // Output logic
    always @(state) begin
        case (state)
            A: begin
                z_output = 1'b0;
            end
            
            B: begin
                z_output = 1'b1;
            end
        endcase
    end
    
    // Assign output
    assign z = z_output;
    
endmodule
