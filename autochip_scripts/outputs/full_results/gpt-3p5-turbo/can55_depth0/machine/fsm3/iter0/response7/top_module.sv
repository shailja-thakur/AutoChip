module top_module (
    input clk,
    input in,
    input areset,
    output out
);

reg [1:0] state;
reg out;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b00; // reset to state A
        out <= 0;
    end else begin
        case (state)
            2'b00: begin // current state is A
                if (in) begin
                    state <= 2'b01; // next state is B
                end else begin
                    state <= 2'b00; // next state is A
                end
            end
            2'b01: begin // current state is B
                if (in) begin
                    state <= 2'b01; // next state is B
                end else begin
                    state <= 2'b10; // next state is C
                end
            end
            2'b10: begin // current state is C
                if (in) begin
                    state <= 2'b11; // next state is D
                end else begin
                    state <= 2'b00; // next state is A
                end
            end
            2'b11: begin // current state is D
                if (in) begin
                    state <= 2'b01; // next state is B
                end else begin
                    state <= 2'b10; // next state is C
                end
            end
        endcase
        
        if (state == 2'b11) begin // state is D
            out <= 1;
        end else begin
            out <= 0;
        end
    end
end

endmodule
