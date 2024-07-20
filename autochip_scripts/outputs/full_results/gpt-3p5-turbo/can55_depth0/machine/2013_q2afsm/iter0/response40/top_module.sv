module top_module (
    input clk,
    input resetn,
    input [3:0] r,
    output reg [3:0] g
);

    reg [1:0] state;
    reg [1:0] next_state;
    
    always @(posedge clk) begin
        if (!resetn) begin
            state <= 2'b00; // Set state to A
        end else begin
            state <= next_state; // Update state with next_state
        end
    end
    
    always @* begin
        case (state)
            2'b00: begin
                if (r[2]) begin
                    next_state = 2'b10; // Next state is C
                end else if (r[3]) begin
                    next_state = 2'b11; // Next state is D
                end else if (r[1]) begin
                    next_state = 2'b01; // Next state is B
                end else begin
                    next_state = 2'b00; // Next state is A
                end
            end
            
            2'b01: begin
                if (r[1]) begin
                    next_state = 2'b01; // Next state is B
                end else begin
                    next_state = 2'b00; // Next state is A
                end
            end
            
            2'b10: begin
                if (r[2]) begin
                    next_state = 2'b10; // Next state is C
                end else begin
                    next_state = 2'b00; // Next state is A
                end
            end
            
            2'b11: begin
                if (r[3]) begin
                    next_state = 2'b11; // Next state is D
                end else begin
                    next_state = 2'b00; // Next state is A
                end
            end
        endcase
    end
    
    always @* begin
        g[1] = (state == 2'b01) ? 1'b1 : 1'b0; // g[1] is high if state is B, otherwise low
        g[2] = (state == 2'b10) ? 1'b1 : 1'b0; // g[2] is high if state is C, otherwise low
        g[3] = (state == 2'b11) ? 1'b1 : 1'b0; // g[3] is high if state is D, otherwise low
    end

endmodule
