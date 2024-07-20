module top_module (
    input clk,
    input reset,
    input w,
    output z
);
    
    reg [2:0] state;
    reg [2:0] next_state;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 3'b111;
        else
            state <= next_state;
    end
    
    always @(state or w) begin
        case(state)
            3'b000: begin
                if (w)
                    next_state = 3'b010;
                else
                    next_state = 3'b000;
            end
            
            3'b001: begin
                next_state = 3'b001;
            end
            
            3'b010: begin
                if (w)
                    next_state = 3'b011;
                else
                    next_state = 3'b100;
            end
            
            3'b011: begin
                if (w)
                    next_state = 3'b010;
                else
                    next_state = 3'b001;
            end
            
            3'b100: begin
                if (w)
                    next_state = 3'b100;
                else
                    next_state = 3'b010;
            end
            
            3'b101: begin
                if (w)
                    next_state = 3'b011;
                else
                    next_state = 3'b001;
            end
            
            3'b110: begin
                if (w)
                    next_state = 3'b100;
                else
                    next_state = 3'b010;
            end
            
            3'b111: begin
                if (w)
                    next_state = 3'b010;
                else
                    next_state = 3'b001;
            end
            
        endcase
    end
    
    always @(next_state) begin
        case(next_state)
            3'b000: z = 1'b0;
            3'b001: z = 1'b1;
            3'b010: z = 1'b0;
            3'b011: z = 1'b0;
            3'b100: z = 1'b0;
            3'b101: z = 1'b0;
            3'b110: z = 1'b1;
            3'b111: z = 1'b0;
        endcase
    end
    
endmodule
