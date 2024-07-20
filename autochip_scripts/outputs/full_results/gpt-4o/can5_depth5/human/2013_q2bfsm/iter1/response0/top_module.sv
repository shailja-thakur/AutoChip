module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    reg [2:0] state, next_state;
    reg [1:0] y_count;

    // State encoding
    localparam [2:0] S_A = 3'd0,
                     S_B = 3'd1,
                     S_C = 3'd2,
                     S_D = 3'd3,
                     S_E = 3'd4,
                     S_F = 3'd5,
                     S_G = 3'd6;

    // State transition
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= S_A;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic and output logic
    always @(*) begin
        f = 1'b0;
        g = 1'b0;
        next_state = state;
		
        case (state)
            S_A: begin
                if (!resetn) begin
                    next_state = S_A;
                end else begin
                    next_state = S_B;
                end
            end
			
            S_B: begin
                f = 1'b1;
                next_state = S_C;
            end
			
            S_C: begin
                if (x) begin
                    next_state = S_D;
                end else begin
                    next_state = S_C;
                end
            end
			
            S_D: begin
                if (!x) begin
                    next_state = S_E;
                end else begin
                    next_state = S_C;
                end
            end
			
            S_E: begin
                if (x) begin
                    next_state = S_F;
                end else begin
                    next_state = S_C;
                end
            end
			
            S_F: begin
                g = 1'b1;
                if (y) begin
                    next_state = S_F;
                end else if (y_count == 2'b10) begin
                    next_state = S_G;
                end else begin
                    next_state = S_F;
                end
            end
			
            S_G: begin
                g = 1'b0;
                next_state = S_G;
            end
        endcase
    end

    // Counter for monitoring y input
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            y_count <= 2'b00;
        end else if (state == S_F && !y) begin
            y_count <= y_count + 1'b1;
        end else if (state == S_G || y) begin
            y_count <= 2'b00;
        end
    end
endmodule
