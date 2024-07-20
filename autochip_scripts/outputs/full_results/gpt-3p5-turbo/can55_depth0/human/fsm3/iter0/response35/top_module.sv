module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    reg [1:0] state, next_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b00;
        end else begin
            state <= next_state;
        end
    end
    
    always @(*) begin
        case (state)
            2'b00: begin // State A
                if (in == 1'b0) begin
                    next_state = 2'b00; // Next state is A
                    out = 1'b0; // Output is 0
                end else begin
                    next_state = 2'b01; // Next state is B
                    out = 1'b0; // Output is 0
                end
            end
            
            2'b01: begin // State B
                if (in == 1'b0) begin
                    next_state = 2'b10; // Next state is C
                    out = 1'b0; // Output is 0
                end else begin
                    next_state = 2'b01; // Next state is B
                    out = 1'b0; // Output is 0
                end
            end
            
            2'b10: begin // State C
                if (in == 1'b0) begin
                    next_state = 2'b00; // Next state is A
                    out = 1'b0; // Output is 0
                end else begin
                    next_state = 2'b11; // Next state is D
                    out = 1'b0; // Output is 0
                end
            end
            
            2'b11: begin // State D
                if (in == 1'b0) begin
                    next_state = 2'b10; // Next state is C
                    out = 1'b1; // Output is 1
                end else begin
                    next_state = 2'b01; // Next state is B
                    out = 1'b1; // Output is 1
                end
            end
        endcase
    end
    
endmodule
