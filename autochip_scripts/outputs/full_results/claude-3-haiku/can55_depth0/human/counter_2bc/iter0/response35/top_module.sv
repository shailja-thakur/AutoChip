module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

logic [1:0] count;

always_ff @(posedge clk, posedge areset) begin
    if (areset) begin
        count <= 2'b01; // Reset to weakly not-taken
    end
    else if (train_valid) begin
        if (train_taken) begin
            if (count < 3) begin // Saturate at 3
                count <= count + 1;
            end
        end
        else begin
            if (count > 0) begin // Saturate at 0
                count <= count - 1;
            end
        end
    end
end

assign state = count;

endmodule
