module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    reg [1:0] state;
    wire [1:0] next_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b00; // state A
        end else begin
            state <= next_state;
        end
    end

    always @* begin
        case(state)
            2'b00: begin // state A
                if (in) begin
                    next_state = 2'b01; // state B
                end else begin
                    next_state = 2'b00; // state A
                end
            end
            2'b01: begin // state B
                if (in) begin
                    next_state = 2'b01; // state B
                end else begin
                    next_state = 2'b10; // state C
                end
            end
            2'b10: begin // state C
                if (in) begin
                    next_state = 2'b11; // state D
                end else begin
                    next_state = 2'b00; // state A
                end
            end
            2'b11: begin // state D
                if (in) begin
                    next_state = 2'b01; // state B
                end else begin
                    next_state = 2'b10; // state C
                end
            end
        endcase
    end

    assign out = (state == 2'b11); // state D

endmodule
