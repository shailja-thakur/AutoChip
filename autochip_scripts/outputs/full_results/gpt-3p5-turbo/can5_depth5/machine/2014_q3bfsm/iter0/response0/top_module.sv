module top_module (
  input clk,
  input reset,
  input x,
  output reg z
);

reg [2:0] state, next_state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 3'b001; // Initialize state to A
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        3'b000: begin // A state
            if (x) begin
                next_state = 3'b010; // Transition to B state
            end else begin
                next_state = 3'b000; // Stay in A state
            end
        end
        
        3'b001: begin // B state
            if (x) begin
                next_state = 3'b110; // Transition to E state
            end else begin
                next_state = 3'b001; // Stay in B state
            end
        end
        
        3'b010: begin // C state
            if (x) begin
                next_state = 3'b010; // Transition to B state
            end else begin
                next_state = 3'b010; // Stay in C state
            end
        end
        
        3'b011: begin // D state
            if (x) begin
                next_state = 3'b010; // Transition to C state
            end else begin
                next_state = 3'b010; // Stay in D state
            end
        end
        
        3'b100: begin // E state
            if (x) begin
                next_state = 3'b100; // Stay in E state
            end else begin
                next_state = 3'b011; // Transition to D state
            end
        end
        
        default: next_state = 3'b000; // Default to A state
    endcase
end

always @(posedge clk) begin
    if (state == 3'b100 || state == 3'b101) begin // States D and E
        z <= 1'b1; // Set output to high
    end else begin
        z <= 1'b0; // Set output to low
    end
end

endmodule
