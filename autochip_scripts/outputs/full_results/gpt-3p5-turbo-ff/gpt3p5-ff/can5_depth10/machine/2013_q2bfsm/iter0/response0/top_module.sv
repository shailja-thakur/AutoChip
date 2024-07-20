module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output f,
    output g
);

reg [3:0] state_reg;
reg [3:0] state_next;
assign f = (state_reg == 2'b01);
assign g = (state_reg[2] || state_reg[1] || state_reg[0]);

always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        state_reg <= 4'd0;
    end else begin
        state_reg <= state_next;
    end
end

always @* begin
    case (state_reg)
        2'b00: begin // A state
            if (x) begin
                state_next = 2'b01; // B state
            end else begin
                state_next = 2'b00; // A state
            end
        end
        
        2'b01: begin // B state
            state_next = 2'b10; // S0 state
        end
        
        2'b10: begin // S0 state
            if (x) begin
                state_next = 2'b11; // S1 state
            end else begin
                state_next = 2'b10; // S0 state
            end
        end
        
        2'b11: begin // S1 state
            if (x) begin
                state_next = 2'b11; // S1 state
            end else begin
                state_next = 2'b100; // S10 state
            end
        end
        
        2'b100: begin // S10 state
            if (x) begin
                state_next = 2'b101; // G1 state
            end else begin
                state_next = 2'b10; // S0 state
            end
        end
        
        2'b101: begin // G1 state
            if (y) begin
                state_next = 2'b110; // P1 state
            end else begin
                state_next = 2'b111; // G2 state
            end
        end
        
        2'b110: begin // P1 state
            state_next = 2'b110; // P1 state
        end
        
        2'b111: begin // G2 state
            if (y) begin
                state_next = 2'b110; // P1 state
            end else begin
                state_next = 2'b1000; // P0 state
            end
        end
        
        2'b1000: begin // P0 state
            state_next = 2'b1000; // P0 state
        end
    endcase
end

endmodule
