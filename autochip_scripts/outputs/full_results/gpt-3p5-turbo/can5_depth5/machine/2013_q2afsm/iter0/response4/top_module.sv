module top_module (
    input clk,
    input resetn,
    input [2:0] r,
    output [2:0] g
);
    
    reg [1:0] state;
    reg [1:0] next_state;
    
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= 2'b00; // state A
        end else begin
            state <= next_state;
        end
    end
    
    always @* begin
        case (state)
            2'b00: begin // state A
                if (r[2]) begin
                    next_state = 2'b10; // state C
                end else if (r[1]) begin
                    next_state = 2'b01; // state B
                end else if (r[0]) begin
                    next_state = 2'b11; // state D
                end else begin
                    next_state = 2'b00; // state A
                end
            end
            
            2'b01: begin // state B
                if (r[1]) begin
                    next_state = 2'b01; // state B
                end else begin
                    next_state = 2'b00; // state A
                end
            end
            
            2'b10: begin // state C
                if (r[2]) begin
                    next_state = 2'b10; // state C
                end else begin
                    next_state = 2'b00; // state A
                end
            end
            
            2'b11: begin // state D
                if (r[0]) begin
                    next_state = 2'b11; // state D
                end else begin
                    next_state = 2'b00; // state A
                end
            end
        endcase
    end
    
    assign g[0] = (state == 2'b01); // g[1]
    assign g[1] = (state == 2'b10); // g[2]
    assign g[2] = (state == 2'b11); // g[3]
    
endmodule
