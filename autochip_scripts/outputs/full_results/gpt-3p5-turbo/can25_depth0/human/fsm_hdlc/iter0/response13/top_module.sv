module top_module (
    input clk,
    input reset,
    input in,
    output disc,
    output flag,
    output err);

    reg [2:0] state;
    reg [2:0] next_state;
    
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            state <= 3'b000;
        end else begin
            state <= next_state;
        end
    end
    
    always @(*) begin
        case (state)
            
            // State when input is 0
            3'b000: begin
                if (in) begin
                    next_state = 3'b001;
                end else begin
                    next_state = 3'b000;
                end
            end
            
            // State when 1 is detected
            3'b001: begin
                if (in) begin
                    next_state = 3'b010;
                end else begin
                    next_state = 3'b000;
                end
            end
            
            // State when 011111 is detected
            3'b010: begin
                if (in) begin
                    next_state = 3'b011;
                end else begin
                    next_state = 3'b000;
                end
            end
            
            // State when 0111110 is detected (discard)
            3'b011: begin
                if (in) begin
                    next_state = 3'b011;
                end else begin
                    next_state = 3'b100;
                end
            end
            
            // State when 01111110 is detected (flag)
            3'b100: begin
                if (in) begin
                    next_state = 3'b101;
                end else begin
                    next_state = 3'b000;
                end
            end
            
            // State when 01111111 is detected (error)
            3'b101: begin
                if (in) begin
                    next_state = 3'b101;
                end else begin
                    next_state = 3'b110;
                end
            end
            
            // State when 01111111... is detected (error)
            3'b110: begin
                if (in) begin
                    next_state = 3'b110;
                end else begin
                    next_state = 3'b000;
                end
            end
            
        endcase
    end
    
    assign disc = (state == 3'b100);
    assign flag = (state == 3'b101);
    assign err = (state == 3'b110);

endmodule
