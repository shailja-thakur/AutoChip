module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output f,
    output g
);
    
    reg [1:0] state;
    reg next_state;
    
    always @(posedge clk) begin
        if (~resetn) begin
            state <= 2'b00; // State A
        end else begin
            state <= next_state;
        end
    end
    
    always @(*) begin
        // Default assignments
        f = 1'b0;
        g = 1'b0;
        next_state = state;
        
        case (state)
            2'b00: begin // State A
                if (~resetn) begin
                    f = 1'b0;
                end else begin
                    next_state = 2'b01; // Transition to State B
                end
            end
            
            2'b01: begin // State B
                f = 1'b1;
                next_state = 2'b10; // Transition to State C
            end

            2'b10: begin // State C
                if (x===3'b101) begin
                    g = 1'b1;
                    next_state = 2'b11; // Transition to State D
                end
            end
            
            2'b11: begin // State D
                g = 1'b1;
                if (y===1'b1) begin
                    next_state = 2'b11; // Stay in State D
                end else begin
                    next_state = 2'b00; // Transition to State A
                end
            end
        endcase
    end
    
endmodule
