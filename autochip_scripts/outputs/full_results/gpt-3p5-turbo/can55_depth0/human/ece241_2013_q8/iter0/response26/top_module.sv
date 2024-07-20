module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [2:0] state;
reg z_prev;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= 3'b000; //reset state
        z_prev <= 1'b0;
    end else begin
        case (state)
            // State 0
            3'b000: begin
                if (x == 1'b1)
                    state <= 3'b001; // Move to state 1 on 1 input
                else
                    state <= 3'b000;
            end
            
            // State 1
            3'b001: begin
                if (x == 1'b0)
                    state <= 3'b010; // Move to state 2 on 0 input
                else
                    state <= 3'b001;
            end
            
            // State 2
            3'b010: begin
                if (x == 1'b1)
                    state <= 3'b011; // Move to state 3 on 1 input
                else
                    state <= 3'b000; // Go back to state 0 on any other input
            end
            
            // State 3
            3'b011: begin
                if (x == 1'b1) 
                    state <= 3'b001; // Go back to state 1 on 1 input
                else
                    state <= 3'b010; // Stay in state 2 on any other input
            end
        endcase
    end
end

always @(posedge clk) begin
    // Output logic - assert z when "101" sequence is detected
    if (state == 3'b011 && z_prev && x == 1'b0)
        z <= 1'b1;
    else
        z <= 1'b0;
        
    // Store previous z value for the next clock cycle
    z_prev <= z;
end
    
endmodule
