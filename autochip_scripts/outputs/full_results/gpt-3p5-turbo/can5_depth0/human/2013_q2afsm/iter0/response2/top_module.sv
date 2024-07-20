module fsm_module (
    input clk,
    input resetn,
    input [2:0] r,
    output [2:0] g
);
 
    // Define states
    localparam A = 3'b000;
    localparam B = 3'b001;
    localparam C = 3'b010;
    localparam D = 3'b011;
 
    // Define state register
    reg [2:0] state_reg;
    reg [2:0] state_next;
 
    // Define output register
    reg [2:0] g_reg;
 
    // Define combinational logic for next state and outputs
    always @ (state_reg or r) begin
        case (state_reg)
            A: begin
                case (r)
                    3'b000: begin
                        state_next = A;
                        g_reg = 3'b000;
                    end
 
                    3'b001: begin
                        state_next = B;
                        g_reg = 3'b001;
                    end
 
                    3'b010: begin
                        state_next = C;
                        g_reg = 3'b000;
                    end
 
                    3'b011: begin
                        state_next = D;
                        g_reg = 3'b000;
                    end
                endcase
            end
 
            B: begin
                case (r)
                    3'b000: begin
                        state_next = A;
                        g_reg = 3'b000;
                    end
 
                    3'b001: begin
                        state_next = B;
                        g_reg = 3'b001;
                    end
 
                    3'b010: begin
                        state_next = C;
                        g_reg = 3'b000;
                    end
 
                    3'b011: begin
                        state_next = D;
                        g_reg = 3'b000;
                    end
                endcase
            end
 
            C: begin
                case (r)
                    3'b000: begin
                        state_next = A;
                        g_reg = 3'b000;
                    end
 
                    3'b001: begin
                        state_next = B;
                        g_reg = 3'b001;
                    end
 
                    3'b010: begin
                        state_next = C;
                        g_reg = 3'b010;
                    end
 
                    3'b011: begin
                        state_next = D;
                        g_reg = 3'b000;
                    end
                endcase
            end
 
            D: begin
                case (r)
                    3'b000: begin
                        state_next = A;
                        g_reg = 3'b000;
                    end
 
                    3'b001: begin
                        state_next = B;
                        g_reg = 3'b001;
                    end
 
                    3'b010: begin
                        state_next = C;
                        g_reg = 3'b010;
                    end
 
                    3'b011: begin
                        state_next = D;
                        g_reg = 3'b011;
                    end
                endcase
            end
        endcase
    end
 
    // Define synchronous state update
    always @ (posedge clk or negedge resetn) begin
        if (~resetn) begin
            state_reg <= A;
        end else begin
            state_reg <= state_next;
        end
    end
 
    // Assign outputs
    assign g = g_reg;
 
endmodule
module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);
 
    // Instantiate the FSM
    fsm_module fsm_inst (
        .clk(clk),
        .resetn(resetn),
        .r(r),
        .g(g)
    );
 
endmodule
