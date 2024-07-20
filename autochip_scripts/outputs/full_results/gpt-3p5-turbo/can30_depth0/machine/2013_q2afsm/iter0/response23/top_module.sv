module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

reg [3:1] state;
reg [3:1] next_state;

always @(posedge clk) begin
    if (resetn == 0) begin
        state <= 3'b001; // Set state to A
    end else begin
        state <= next_state; // Set state to next_state
    end
end

always @* begin
    case(state)
        3'b001: begin // State A
            if (r[3] == 1) begin
                next_state = 3'b100; // Next state is D
            end else if (r[2] == 1) begin
                next_state = 3'b011; // Next state is C
            end else if (r[1] == 1) begin
                next_state = 3'b010; // Next state is B
            end else begin
                next_state = 3'b001; // Next state is A
            end
        end
        
        3'b010: begin // State B
            if (r[1] == 1) begin
                next_state = 3'b010; // Next state is B
            end else begin
                next_state = 3'b001; // Next state is A
            end
        end
        
        3'b011: begin // State C
            if (r[2] == 1) begin
                next_state = 3'b011; // Next state is C
            end else begin
                next_state = 3'b001; // Next state is A
            end
        end
        
        3'b100: begin // State D
            if (r[3] == 1) begin
                next_state = 3'b100; // Next state is D
            end else begin
                next_state = 3'b001; // Next state is A
            end
        end
    endcase
end

assign g[3] = (state == 3'b100) ? 1'b1 : 1'b0; // Set g[3] high if current state is D
assign g[2] = (state == 3'b011) ? 1'b1 : 1'b0; // Set g[2] high if current state is C
assign g[1] = (state == 3'b010) ? 1'b1 : 1'b0; // Set g[1] high if current state is B

endmodule
