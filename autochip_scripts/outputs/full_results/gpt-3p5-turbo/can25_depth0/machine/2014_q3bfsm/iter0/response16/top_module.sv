module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] state;
reg [2:0] next_state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 3'b001; // Initialize state to A
    end else begin
        state <= next_state;
    end
end

always @* begin
    case (state)
        3'b001: begin // A
            if (x == 1'b0) begin
                next_state = 3'b001; // A
            end else begin
                next_state = 3'b010; // B
            end
        end
        
        3'b010: begin // B
            if (x == 1'b0) begin
                next_state = 3'b010; // B
            end else begin
                next_state = 3'b101; // E
            end
        end
        
        3'b011: begin // C
            if (x == 1'b0) begin
                next_state = 3'b011; // C
            end else begin
                next_state = 3'b010; // B
            end
        end
        
        3'b100: begin // D
            if (x == 1'b0) begin
                next_state = 3'b010; // B
            end else begin
                next_state = 3'b011; // C
            end
        end
        
        3'b101: begin // E
            if (x == 1'b0) begin
                next_state = 3'b100; // D
            end else begin
                next_state = 3'b101; // E
            end
        end
        
        default: next_state = 3'b001; // If state is invalid, set next_state to A
    endcase
end

always @(posedge clk) begin
    if (state == 3'b101 || state == 3'b110) begin // D or E
        z <= 1'b1;
    end else begin
        z <= 1'b0;
    end
end

endmodule
