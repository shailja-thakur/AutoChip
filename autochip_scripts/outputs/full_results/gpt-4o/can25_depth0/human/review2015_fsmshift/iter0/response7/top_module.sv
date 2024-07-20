module top_module(
    input clk,
    input reset,
    output reg shift_ena
);
    reg [2:0] count;
    reg [1:0] state;
    reg [1:0] next_state;
    
    // State encoding
    localparam IDLE = 2'b00;
    localparam SHIFT = 2'b01;
    
    // State transition
    always @(posedge clk) begin
        if (reset) begin
            state <= SHIFT;
        end else begin
            state <= next_state;
        end
    end
    
    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                shift_ena = 0;
                next_state = IDLE;
            end
            SHIFT: begin
                if (count < 4) begin
                    shift_ena = 1;
                    next_state = SHIFT;
                end else begin
                    shift_ena = 0;
                    next_state = IDLE;
                end
            end
            default: begin
                shift_ena = 0;
                next_state = IDLE;
            end
        endcase
    end
    
    // Counter logic
    always @(posedge clk) begin
        if (reset) begin
            count <= 0;
        end else if (state == SHIFT) begin
            count <= count + 1;
        end
    end
    
endmodule
