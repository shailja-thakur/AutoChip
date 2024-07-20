module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

    reg [3:1] state;
    reg [3:1] next_state;
    
    always @(posedge clk) begin
        if (!resetn) begin
            state <= 3'b001; // Set state to A
        end else begin
            state <= next_state; // Update state from next_state
        end
    end
    
    always @(*) begin
        case (state)
            3'b001: begin // If state is A
                if (r[3]) begin
                    next_state = 3'b100; // If r[3] is high, set next_state to D
                end else if (r[2]) begin
                    next_state = 3'b011; // If r[2] is high, set next_state to C
                end else if (r[1]) begin
                    next_state = 3'b010; // If r[1] is high, set next_state to B
                end else begin
                    next_state = 3'b001; // If none of the bits are high, set next_state to A
                end
            end
            3'b010: begin // If state is B
                if (r[1]) begin
                    next_state = 3'b010; // If r[1] is high, set next_state to B
                end else begin
                    next_state = 3'b001; // Otherwise, set next_state to A
                end
            end
            3'b011: begin // If state is C
                if (r[2]) begin
                    next_state = 3'b011; // If r[2] is high, set next_state to C
                end else begin
                    next_state = 3'b001; // Otherwise, set next_state to A
                end
            end
            3'b100: begin // If state is D
                if (r[3]) begin
                    next_state = 3'b100; // If r[3] is high, set next_state to D
                end else begin
                    next_state = 3'b001; // Otherwise, set next_state to A
                end
            end
        endcase
    end
    
    assign g[1] = (state == 3'b010) ? 1'b1 : 1'b0; // If state is B, g[1] is high
    assign g[2] = (state == 3'b011) ? 1'b1 : 1'b0; // If state is C, g[2] is high
    assign g[3] = (state == 3'b100) ? 1'b1 : 1'b0; // If state is D, g[3] is high
endmodule
