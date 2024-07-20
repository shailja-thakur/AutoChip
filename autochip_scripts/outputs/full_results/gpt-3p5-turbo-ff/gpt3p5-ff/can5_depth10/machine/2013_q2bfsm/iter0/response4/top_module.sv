module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output f,
    output g
);

    reg [3:0] state, next_state;

    assign f = (state == 1'b1) ? 1'b1 : 1'b0;
    assign g = (state == 2'b10 || state == 2'b11 || state == 2'b100) ? 1'b1 : 1'b0;

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= 4'b0000;
        end else begin
            state <= next_state;
        end
    end

    always @* begin
        case(state)
            4'b0000: begin // A
                if (x) begin
                    next_state = 4'b0010; // B
                end else begin
                    next_state = 4'b0000; // A
                end
            end
            4'b0010: begin // B
                next_state = 4'b0001; // S0
            end
            4'b0001: begin // S0
                if(x) begin
                    next_state = 4'b0011; // S1
                end else begin
                    next_state = 4'b0001; // S0
                end
            end
            4'b0011: begin // S1
                if(x) begin
                    next_state = 4'b0011; // S1
                end else begin
                    next_state = 4'b1010; // S10
                end
            end
            4'b1010: begin // S10
                if(x) begin
                    next_state = 4'b0100; // G1
                end else begin
                    next_state = 4'b0001; // S0
                end
            end
            4'b0100: begin // G1
                if(y) begin
                    next_state = 4'b0101; // P1
                end else begin
                    next_state = 4'b0110; // G2
                end
            end
            4'b0110: begin // G2
                if(y) begin
                    next_state = 4'b0101; // P1
                end else begin
                    next_state = 4'b0111; // P0
                end
            end
            4'b0111: begin // P0
                next_state = 4'b0111; // P0
            end
            4'b0101: begin // P1
                next_state = 4'b0101; // P1
            end
            default: begin
                next_state = 4'b0000; // A
            end
        endcase
    end

endmodule
