module top_module (
    input clk,
    input resetn,
    input [2:0] r,
    output reg [2:0] g
);
    
reg [2:0] state;
reg [2:0] next_state;

always @(posedge clk) begin
    if (!resetn)
        state <= 3'b000;
    else
        state <= next_state;
end

always @* begin
    case (state)
        3'b000: begin // State A
            if (r[2])
                next_state = 3'b100; // State D
            else if (r[1])
                next_state = 3'b011; // State C
            else if (r[0])
                next_state = 3'b010; // State B
            else
                next_state = 3'b000; // State A
        end
        
        3'b010: begin // State B
            if (r[1])
                next_state = 3'b010; // State B
            else
                next_state = 3'b000; // State A
        end
        
        3'b011: begin // State C
            if (r[2])
                next_state = 3'b011; // State C
            else
                next_state = 3'b000; // State A
        end
        
        3'b100: begin // State D
            if (r[0])
                next_state = 3'b100; // State D
            else
                next_state = 3'b000; // State A
        end
    endcase
end

always @(state) begin
    case (state)
        3'b010: g = 3'b001;
        3'b011: g = 3'b010;
        3'b100: g = 3'b100;
        default: g = 3'b000;
    endcase
end

endmodule
