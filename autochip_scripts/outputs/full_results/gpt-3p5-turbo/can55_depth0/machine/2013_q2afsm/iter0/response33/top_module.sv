module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);
    reg [3:1] state;
    reg [3:1] next;

    always @(posedge clk) begin
        if (~resetn) begin
            state <= 3'b001; // Set state to A
        end else begin
            state <= next;
        end
    end

    always @(*) begin
        case(state)
            3'b001: begin // State A
                if (r[3]) begin
                    next = 3'b100; // Next state is D
                end else if (r[2]) begin
                    next = 3'b011; // Next state is C
                end else if (r[1]) begin
                    next = 3'b010; // Next state is B
                end else begin
                    next = 3'b001; // Next state is A
                end
            end
            
            3'b010: begin // State B
                if (r[1]) begin
                    next = 3'b010; // Next state is B
                end else begin
                    next = 3'b001; // Next state is A
                end
            end
            
            3'b011: begin // State C
                if (r[2]) begin
                    next = 3'b011; // Next state is C
                end else begin
                    next = 3'b001; // Next state is A
                end
            end
            
            3'b100: begin // State D
                if (r[3]) begin
                    next = 3'b100; // Next state is D
                end else begin
                    next = 3'b001; // Next state is A
                end
            end
        endcase
    end
    
    assign g = (state == 3'b010) ? 3'b001 : (state == 3'b011) ? 3'b010 : (state == 3'b100) ? 3'b100 : 3'b000;
endmodule
