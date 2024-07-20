module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

    // State declaration
    reg [1:0] state, next_state;
    
    // Output assignment
    assign g[1] = (state == 2'b01 || state == 2'b10) ? 1'b0 : 1'b1;
    assign g[2] = (state == 2'b10) ? 1'b0 : 1'b1;
    assign g[3] = (state == 2'b10) ? 1'b1 : 1'b0;
    
    // Next state logic
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= 2'b00;
        else
            state <= next_state;
    end
    
    // State transition logic
    always @(*) begin
        case (state)
            2'b00: begin
                if (r[1])
                    next_state = 2'b10;
                else if (r[2])
                    next_state = 2'b11;
                else if (r[3])
                    next_state = 2'b01;
                else
                    next_state = 2'b00;
            end
            2'b01: begin
                if (r[1])
                    next_state = 2'b01;
                else
                    next_state = 2'b00;
            end
            2'b10: begin
                if (r[1])
                    next_state = 2'b10;
                else if (r[2])
                    next_state = 2'b10;
                else
                    next_state = 2'b00;
            end
            2'b11: begin
                if (r[2])
                    next_state = 2'b11;
                else
                    next_state = 2'b00;
            end
            default: next_state = 2'b00;
        endcase
    end

endmodule
