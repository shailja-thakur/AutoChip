module top_module (
    input clk,
    input in,
    input reset,
    output out
);

reg state, next_state;

// State encoding
parameter A = 0;
parameter B = 1;

// State transition and output logic
always @(*) begin
    case (state)
        A: begin
            if (in == 0) begin
                next_state = B;
                out = 0;
            end else begin
                next_state = A;
                out = 0;
            end
        end
        B: begin
            if (in == 0) begin
                next_state = B;
                out = 1;
            end else begin
                next_state = B;
                out = 1;
            end
        end
    endcase
end

// State register
always @(posedge clk) begin
    if (reset) begin
        state <= B;
    end else begin
        state <= next_state;
    end
end

endmodule
